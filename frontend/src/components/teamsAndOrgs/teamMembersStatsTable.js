import React, { useMemo } from 'react';
import { FormattedMessage, useIntl } from 'react-intl';
import { Tabs, TabList, Tab, TabPanel } from 'react-tabs';
import 'react-tabs/style/react-tabs.css';
import DataTable from 'react-data-table-component';
import { Button } from '../button';
import { exporttoCSVFile } from '../../network/genericCSVExport';
import { Link } from 'react-router-dom';
import { UserAvatar } from '../user/avatar';
import messages from './messages';

const secondsToHHMMSS = (seconds) => {
  return (Math.floor(seconds / 3600)) + ":" + ("0" + Math.floor(seconds / 60) % 60).slice(-2) + ":" + ("0" + seconds % 60).slice(-2)
}


const UserCell = ({ row }) => {
  return (
    <span>
      <UserAvatar
        key={row.userId}
        username={row.username}
        picture={row.pictureUrl}
        size="medium"
        colorClasses="white bg-blue-grey mv1"
      />
      {/* TODO: Link to user contributions page filtered by team */}
      <Link to={`/contributions/teamUserLevelDetailed?name=${row.username}&status=MAPPED`}>
        <b>{row.username}</b>
      </Link>
    </span>
  );
};

export const TeamMembersStatsTable = ({ stats, teamName }) => {
  /*
   * Table showing user stats for a particular team. Filterable by date range
   */

  const intl = useIntl();

  const summaryKeys = ['username', 'totalTimeSpent', 'tasksMapped', 'tasksValidated'];

  const summaryTableColumns = useMemo(
    () => [
      {
        name: <FormattedMessage {...messages.userName} />,
        selector: (row) => row['username'],
        sortable: true,
        grow: 2,
        minWidth: '100px',
        cell: (row) => <UserCell row={row} />,
      },

      {
        name: <FormattedMessage {...messages.totalTime} />,
        selector: (row) => secondsToHHMMSS(row['totalTimeSpent']),
        sortable: true,
        grow: 2,
        minWidth: '100px',
      },
      {
        name: <FormattedMessage {...messages.tasksMapped} />,
        selector: (row) => row['tasksMapped'],
        sortable: true,
        grow: 2,

        minWidth: '100px',
      },
      {
        name: <FormattedMessage {...messages.tasksValidated} />,
        selector: (row) => row['tasksValidated'],
        sortable: true,
        grow: 2,

        minWidth: '200px',
      },
    ],
    [],
  );

  const validatedKeys = [
    'username',
    'tasksValidated',
    'timeSpentValidating',
    'averageValidationTime',
  ];

  const validatedTableColumns = useMemo(
    () => [
      {
        name: <FormattedMessage {...messages.userName} />,
        selector: (row) => row['username'],
        sortable: true,
        grow: 2,
        minWidth: '100px',
        cell: (row) => <UserCell row={row} />,
      },

      {
        name: <FormattedMessage {...messages.tasksValidated} />,
        selector: (row) => row['tasksValidated'],
        sortable: true,
        grow: 2,
        minWidth: '100px',
      },
      {
        name: <FormattedMessage {...messages.timeSpentValidating} />,
        selector: (row) => secondsToHHMMSS(row['timeSpentValidating']),
        sortable: true,
        grow: 2,
        minWidth: '100px',
      },
      {
        name: <FormattedMessage {...messages.averageTimePerTask} />,
        selector: (row) => secondsToHHMMSS(row['averageValidationTime']),
        sortable: true,
        grow: 2,
        minWidth: '200px',
      },
    ],
    [],
  );

  const mappedKeys = ['username', 'tasksMapped', 'timeSpentMapping', 'averageMappingTime'];

  const mappedTableColumns = useMemo(
    () => [
      {
        name: <FormattedMessage {...messages.userName} />,
        selector: (row) => row['username'],
        sortable: true,
        grow: 2,
        minWidth: '100px',
        cell: (row) => <UserCell row={row} />,
      },

      {
        name: <FormattedMessage {...messages.tasksMapped} />,
        selector: (row) => row['tasksMapped'],
        sortable: true,
        grow: 2,
        minWidth: '100px',
      },
      {
        name: <FormattedMessage {...messages.timeSpentMapping} />,
        selector: (row) => secondsToHHMMSS(row['timeSpentMapping']),
        sortable: true,
        grow: 2,
        minWidth: '100px',
      },
      {
        name: <FormattedMessage {...messages.averageTimePerTask} />,
        selector: (row) => secondsToHHMMSS(row['averageMappingTime']),
        sortable: true,
        grow: 2,
        minWidth: '200px',
      },
    ],
    [],
  );

  const handleRowClick = (row, event) => {
    // TODO: make this do something cool
    return;
  };

  const customStyles = {
    headCells: {
      style: {
        fontSize: '15px',
        fontWeight: 'bold',
      },
    },

    cells: {
      style: {
        fontSize: '14px',
      },
    },
  };

  const statsFiltered = (keys) => {
    return stats.map((stat) => {
      return Object.keys(stat)
        .filter((key) => keys.includes(key))
        .reduce((res, key) => {
          // the time fields are in seconds so let's convert to useful time just like the table
          if (key.match(/time/i)) {
            const time = secondsToHHMMSS(stat[key]);
            return {...res, [key]: time};
          }
          return { ...res, [key]: stat[key] };
        }, {});
    });
  };

  const ExportButton = (keys, title) =>
    useMemo(() => {
      return (
        <Button
          className="bg-primary white"
          onClick={() => exporttoCSVFile(statsFiltered(keys), teamName.concat('_', title))}
        >
          <FormattedMessage {...messages.exportCSV} />
        </Button>
      );
    }, [keys, title]);

  return (
    <div className="cf shadow-4 pv3 ph2 bg-white">
      <Tabs>
        <TabList>
          <Tab>
            <FormattedMessage {...messages.summary} />
          </Tab>
          <Tab>
            <FormattedMessage {...messages.mapped} />
          </Tab>
          <Tab>
            <FormattedMessage {...messages.validated} />
          </Tab>
        </TabList>

        <TabPanel>
          <DataTable
            title={<FormattedMessage {...messages.teamTaskSummary} />}
            columns={summaryTableColumns}
            data={stats}
            defaultSortField="title"
            pagination
            highlightOnHover
            customStyles={customStyles}
            onRowClicked={handleRowClick}
            actions={ExportButton(summaryKeys, intl.formatMessage({ ...messages.summary }))}
          />
          <br />
          <br />
        </TabPanel>
        <TabPanel>
          <DataTable
            title={<FormattedMessage {...messages.teamMappingStatistics} />}
            columns={mappedTableColumns}
            data={stats}
            defaultSortField="title"
            pagination
            highlightOnHover
            customStyles={customStyles}
            actions={ExportButton(mappedKeys, intl.formatMessage({ ...messages.mapped }))}
          />
        </TabPanel>
        <TabPanel>
          <DataTable
            title={<FormattedMessage {...messages.teamValidationStatistics} />}
            columns={validatedTableColumns}
            data={stats}
            defaultSortField="title"
            pagination
            highlightOnHover
            customStyles={customStyles}
            actions={ExportButton(validatedKeys, intl.formatMessage({ ...messages.validated }))}
          />
        </TabPanel>
      </Tabs>
    </div>
  );
};
