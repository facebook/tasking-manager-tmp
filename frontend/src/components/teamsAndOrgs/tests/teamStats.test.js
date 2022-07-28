import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
import '@testing-library/jest-dom';

import { ReduxIntlProviders } from '../../../utils/testWithIntl';
import { teamMemberStats } from '../../../network/tests/mockData/teamMemberStats';
import { TeamStats } from '../teamStats';

jest.mock('react-chartjs-2', () => ({
  Bar: () => null,
}));

describe('TeamStats', () => {
  const setQuery = jest.fn();
  const retryFn = jest.fn();
  it('render basic elements', () => {
    render(
      <ReduxIntlProviders>
        <TeamStats
          stats={teamMemberStats.teamMembersStats}
          query={{ startDate: null, endDate: null, campaign: null, location: null }}
        />
      </ReduxIntlProviders>,
    );
    expect(screen.getByText('From')).toBeInTheDocument();
    expect(screen.getByText('To')).toBeInTheDocument();
    expect(screen.getByText('Date Range')).toBeInTheDocument();
    expect(screen.getByText('14:56:32')).toBeInTheDocument();
    expect(screen.getByText('Total time')).toBeInTheDocument();
    expect(screen.getByText('12')).toBeInTheDocument();
    expect(screen.getByText('Tasks mapped')).toBeInTheDocument();
    expect(screen.getByText('6')).toBeInTheDocument();
    expect(screen.getByText('Tasks validated')).toBeInTheDocument();
  });
  it('load correct query values', async () => {
    const { container } = render(
      <ReduxIntlProviders>
        <TeamStats
          stats={teamMemberStats.teamMembersStats}
          setQuery={setQuery}
          query={{ startDate: '2020-04-05', endDate: '2021-01-01', campaign: null, location: null }}
        />
      </ReduxIntlProviders>,
    );
    const startDateInput = container.querySelectorAll('input')[0];
    const endDateInput = container.querySelectorAll('input')[1];
    expect(startDateInput.placeholder).toBe('Click to select a start date');
    expect(startDateInput.value).toBe('2020-04-05');
    expect(endDateInput.placeholder).toBe('Click to select an end date');
    expect(endDateInput.value).toBe('2021-01-01');
  });
  it('show error message if date range exceeds the maximum value', async () => {
    render(
      <ReduxIntlProviders>
        <TeamStats
          stats={teamMemberStats.teamMembersStats}
          setQuery={setQuery}
          query={{ startDate: '2019-04-05', endDate: null, campaign: null, location: null }}
          error={true}
        />
      </ReduxIntlProviders>,
    );
    expect(screen.getByText('An error occurred while loading stats.')).toBeInTheDocument();
    expect(screen.getByText('Date range is longer than one year.')).toBeInTheDocument();
  });
  it('show error message if start date is after end date', async () => {
    render(
      <ReduxIntlProviders>
        <TeamStats
          stats={teamMemberStats.teamMembersStats}
          setQuery={setQuery}
          query={{ startDate: '2019-04-05', endDate: '2018-08-05', campaign: null, location: null }}
          error={true}
        />
      </ReduxIntlProviders>,
    );
    expect(screen.getByText('An error occurred while loading stats.')).toBeInTheDocument();
    expect(screen.getByText('Start date should not be later than end date.')).toBeInTheDocument();
  });
  it('render "Try again" button case the error is not on the dates', async () => {
    render(
      <ReduxIntlProviders>
        <TeamStats
          stats={teamMemberStats.teamMembersStats}
          setQuery={setQuery}
          query={{ startDate: '2020-04-05', endDate: '2021-01-01', campaign: null, location: null }}
          error={true}
          retryFn={retryFn}
        />
      </ReduxIntlProviders>,
    );
    expect(screen.getByText('An error occurred while loading stats.')).toBeInTheDocument();
    expect(screen.getByText('Try again')).toBeInTheDocument();
    fireEvent.click(screen.getByText('Try again'));
    expect(retryFn).toHaveBeenCalled();
  });
});
