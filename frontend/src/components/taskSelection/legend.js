import React, { useState } from 'react';
import { FormattedMessage } from 'react-intl';

import messages from './messages';
import { TaskStatus } from './taskList';
import { LockIcon, ChevronDownIcon, ChevronUpIcon } from '../svgIcons';

export function TasksMapLegend({ imageCaptureMode }) {
  const lineClasses = 'mv2 blue-dark f5';
  const [expand, setExpand] = useState(true);
  return (
    <div className="cf left-1 bottom-2 absolute bg-white pa2 br1">
      <h4
        className="fw6 pointer f4 ttu barlow-condensed mt0 mb2"
        onClick={() => setExpand(!expand)}
      >
        <FormattedMessage {...messages.legend} />
        {expand ? <ChevronDownIcon className="pl2" /> : <ChevronUpIcon className="pl2" />}
      </h4>
      {expand && (
        <div>
          {imageCaptureMode && <>
            <p className={lineClasses}>
              <TaskStatus status="PENDING_IMAGE_CAPTURE" />
            </p>
            <p className={lineClasses}>
              <TaskStatus status="MORE_IMAGES_NEEDED" />
            </p>
            <p className={lineClasses}>
              <TaskStatus status="IMAGE_CAPTURE_DONE" />
            </p>
          </>
          }
          {!imageCaptureMode && (<>
            <p className={lineClasses}>
              <TaskStatus status="READY" />
            </p>
            <p className={lineClasses}>
              <TaskStatus status="MAPPED" />
            </p>
            <p className={lineClasses}>
              <TaskStatus status="INVALIDATED" />
            </p>
            <p className={lineClasses}>
              <TaskStatus status="VALIDATED" />
            </p>
            <p className={lineClasses}>
              <TaskStatus status="BADIMAGERY" />
            </p>
          </>)
          }
          <p className={lineClasses}>
            <TaskStatus status="PRIORITY_AREAS" />
          </p>
          <p className={lineClasses}>
            <LockIcon style={{ paddingTop: '1px' }} className="v-mid h1 w1" />
            <span className="pl2 v-mid">
              <FormattedMessage {...messages[`taskStatus_LOCKED`]} />
            </span>
          </p>
        </div>
      )}
    </div>
  );
}
