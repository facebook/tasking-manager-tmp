import React, { Suspense, useState } from 'react';

import { FormattedMessage } from 'react-intl';
import ReactPlaceholder from 'react-placeholder';

import messages from './messages';
import { TeamMembersStatsTable } from './teamMembersStatsTable';
import { useValidateDateRange } from '../../hooks/UseValidateDateRange';
import { DateFilterPicker, DateRangeFilterSelect } from '../projects/filterSelectFields';

export const TeamStats = ({ query, setQuery, stats, error, loading, retryFn, teamName }) => {
  const { startDate: startDateInQuery, endDate: endDateInQuery } = query;
  const [isCustomDateRange, setIsCustomDateRange] = useState(false);
  const dateValidation = useValidateDateRange(query);

  const fieldsetStyle = 'bn dib pv0-ns pv2 ph2-ns ph1 mh0 mb1';
  const titleStyle = 'dib ttu fw5 blue-grey mb1';

  return (
    <div className="mv4 pull-center cf bg-tan">
      <div className="cf pv4">
        <h3 className="barlow-condensed f2 ma0 dib v-mid ttu">
          <FormattedMessage {...messages.teamStats} />
        </h3>
      </div>
      <div className="pv3 ph2 bg-white blue-dark">
        <div className="w-100 cf flex flex-wrap">
          <DateFilterPicker
            fieldsetName="startDate"
            fieldsetStyle={`${fieldsetStyle} fl`}
            titleStyle={titleStyle}
            selectedValue={startDateInQuery}
            setQueryForChild={setQuery}
            allQueryParamsForChild={query}
            setIsCustomDateRange={setIsCustomDateRange}
          />
          <DateFilterPicker
            fieldsetName="endDate"
            fieldsetStyle={`${fieldsetStyle} fl`}
            titleStyle={titleStyle}
            selectedValue={endDateInQuery}
            setQueryForChild={setQuery}
            allQueryParamsForChild={query}
            setIsCustomDateRange={setIsCustomDateRange}
          />
          <div className="w-60-l w-100 fl">
            <DateRangeFilterSelect
              fieldsetName="dateRange"
              fieldsetStyle={`${fieldsetStyle} w-20-ns w-100`}
              titleStyle={titleStyle}
              selectedValue={startDateInQuery}
              setQueryForChild={setQuery}
              allQueryParamsForChild={query}
              isCustomDateRange={isCustomDateRange}
              setIsCustomDateRange={setIsCustomDateRange}
              startDateInQuery={startDateInQuery}
              endDateInQuery={endDateInQuery}
            />
          </div>
        </div>
        <ReactPlaceholder
          showLoadingAnimation={true}
          rows={26}
          ready={!loading}
          className="pv3 ph2 ph4-ns"
        >
          {!loading && error ? (
            <div className="bg-tan pa4">
              <FormattedMessage {...messages.errorLoadingStats} />
              <div className="pv3">
                {dateValidation && dateValidation.detail ? (
                  <FormattedMessage {...messages[dateValidation.detail]} />
                ) : (
                  <button className="pa1 pointer" onClick={() => retryFn()}>
                    <FormattedMessage {...messages.retry} />
                  </button>
                )}
              </div>
            </div>
          ) : (
            <>
              <div className="pt3 pb3 ph2 cf mr2 w-100">
                <Suspense fallback={<div>loading...</div>}>
                  <TeamMembersStatsTable stats={stats} teamName={teamName} />
                </Suspense>
              </div>
            </>
          )}
        </ReactPlaceholder>
      </div>
    </div>
  );
};
