import React from 'react';
import { render, screen } from '@testing-library/react';
import '@testing-library/jest-dom';

import { ReduxIntlProviders } from '../../../utils/testWithIntl';
import { teamName, teamMemberStats } from '../../../network/tests/mockData/teamMemberStats';
import { TeamMembersStatsTable } from '../teamMembersStatsTable';

test('TeamMemberStatsTable renders the correct values and labels', () => {
  render(
    <ReduxIntlProviders>
      <TeamMembersStatsTable stats={teamMemberStats.teamMembersStats} teamName={teamName} />
    </ReduxIntlProviders>,
  );
  expect(screen.getByText('14:56:32')).toBeInTheDocument();
  expect(screen.getByText('Total time')).toBeInTheDocument();
  expect(screen.getByText('12')).toBeInTheDocument();
  expect(screen.getByText('Tasks mapped')).toBeInTheDocument();
  expect(screen.getByText('6')).toBeInTheDocument();
  expect(screen.getByText('Tasks validated')).toBeInTheDocument();
});
