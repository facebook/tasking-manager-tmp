import React, { useContext, useState, useLayoutEffect } from 'react';
import Select from 'react-select';
import { FormattedMessage } from 'react-intl';
import DatePicker from 'react-datepicker';
import { SwitchToggle } from '../formInputs';
import messages from './messages';
import { StateContext, styleClasses } from '../../views/projectEdit';
import { Code } from '../code';
import { fetchLocalJSONAPI } from '../../network/genericJSONRequest';
import { useImageryOption, IMAGERY_OPTIONS } from '../../hooks/UseImageryOption';
import { MAPILLARY_TOKEN } from '../../config';
import axios from 'axios';

export const ImageryForm = () => {
  const { projectInfo, setProjectInfo } = useContext(StateContext);
  const [licenses, setLicenses] = useState(null);

  const [organization, setOrganization] = useState(null);

  useLayoutEffect(() => {
    const fetchLicenses = async () => {
      fetchLocalJSONAPI('licenses/')
        .then((res) => setLicenses(res.licenses))
        .catch((e) => console.log(e));
    };
    fetchLicenses();
  }, [setLicenses]);

  if (projectInfo.mapillaryOrganizationId) {
    axios.get(`https://graph.mapillary.com/${projectInfo.mapillaryOrganizationId}?access_token=${MAPILLARY_TOKEN}&fields=name`)
      .then(resp => setOrganization(resp.data.name))
      .catch(() => setOrganization(null))
  }

  let defaultValue = null;
  if (licenses !== null && projectInfo.licenseId !== null) {
    defaultValue = licenses.filter((l) => l.licenseId === projectInfo.licenseId)[0];
  }

  return (
    <div className="w-100">
      <div className={styleClasses.divClass}>
        <label className={styleClasses.labelClass}>
          <FormattedMessage {...messages.imagery} />
        </label>
        <ImageryField imagery={projectInfo.imagery} setProjectInfo={setProjectInfo} />

      </div>

      <div className={styleClasses.divClass}>
        <label className={styleClasses.labelClass}>
          <FormattedMessage {...messages.license} />
        </label>
        <Select
          classNamePrefix="react-select"
          isClearable={true}
          getOptionLabel={(option) => option.name}
          getOptionValue={(option) => option.licenseId}
          value={defaultValue}
          options={licenses}
          placeholder={<FormattedMessage {...messages.selectLicense} />}
          onChange={(l) => {
            let licenseId = null;
            if (l !== null) licenseId = l.licenseId;
            setProjectInfo((p) => ({ ...p, licenseId: licenseId }));
          }}
          className="w-50 z-1"
        />
      </div>

      <div className={styleClasses.divClass}>
        <label className={styleClasses.labelClass}>
          <FormattedMessage {...messages.imageCaptureMode} />
        </label>
        <p className={styleClasses.pClass}>
          <FormattedMessage {...messages.imageCaptureModeInfo} />
        </p>
        <SwitchToggle
          label={<FormattedMessage {...messages.imageCaptureMode} />}
          labelPosition="right"
          isChecked={projectInfo.imageCaptureMode}
          onChange={() => setProjectInfo({ ...projectInfo, imageCaptureMode: !projectInfo.imageCaptureMode })}
        />
      </div>

      {projectInfo.imageCaptureMode && (
        <>
          <div className={styleClasses.divClass}>
            <label className={styleClasses.labelClass}>
              <FormattedMessage {...messages.imageryCaptureDate} />
            </label>
            <FormattedMessage {...messages.imageryCaptureDateAfter} />
            <span>&nbsp;&nbsp;</span>
            <DatePicker
              selected={Date.parse(projectInfo.earliestStreetImagery)}
              onChange={(date) =>
                setProjectInfo({
                  ...projectInfo,
                  earliestStreetImagery: date,
                })
              }
              placeholderText="DD/MM/YYYY"
              dateFormat="dd/MM/yyyy"
              className={styleClasses.inputClass}
              showYearDropdown
              scrollableYearDropdown
            />
          </div>

          <div className={styleClasses.divClass}>
            <label className={styleClasses.labelClass}>
              <FormattedMessage {...messages.mapillaryOrganizationId} />
            </label>
            <p className={styleClasses.pClass}>
              <FormattedMessage {...messages.mapillaryOrganizationIdInfo} />
            </p>

            <b><FormattedMessage {...messages.mapillaryOrganizationSelected} /></b>
            <span>{organization}</span>

            <input
              className={styleClasses.inputClass}
              type="text"
              name="mapillaryOrganizationId"
              value={projectInfo.mapillaryOrganizationId || ''}
              onChange={(e) => {
                setProjectInfo({
                  ...projectInfo,
                  mapillaryOrganizationId: e.target.value,
                });
              }}
            />
          </div>
        </>
      )
      }
    </div>
  );
};

const ImageryField = ({ imagery, setProjectInfo }) => {
  const imageryValue = useImageryOption(imagery);
  const [showInputField, setShowInputField] = useState(
    imageryValue && imageryValue.value === 'custom' ? true : false,
  );

  const onInputChange = (e) => setProjectInfo((p) => ({ ...p, imagery: e.target.value }));

  const onSelectChange = (option) => {
    if (option) {
      if (option.value === 'custom') {
        setShowInputField(true);
        setProjectInfo((p) => ({ ...p, imagery: 'https://...' }));
      } else {
        setShowInputField(false);
        setProjectInfo((p) => ({ ...p, imagery: option.value }));
      }
    } else {
      setShowInputField(false);
      setProjectInfo((p) => ({ ...p, imagery: null }));
    }
  };

  const exampleUrl = 'tms[22]:https://hiu-maps.net/hot/1.0.0/kathmandu_flipped/{zoom}/{x}/{y}.png';

  return (
    <>
      <Select
        classNamePrefix="react-select"
        isClearable={true}
        value={imageryValue}
        options={IMAGERY_OPTIONS}
        placeholder={<FormattedMessage {...messages.selectImagery} />}
        onChange={onSelectChange}
        className="w-50 z-2"
      />
      {showInputField && (
        <>
          <input
            className={styleClasses.inputClass}
            onChange={onInputChange}
            type="text"
            name="imagery"
            value={imagery}
          />
          <p className={styleClasses.pClass}>
            <FormattedMessage
              {...messages.imageryURLNote}
              values={{
                exampleUrl: (
                  <span className="db">
                    <Code>{exampleUrl}</Code>
                  </span>
                ),
              }}
            />
          </p>
        </>
      )}
    </>
  );
};
