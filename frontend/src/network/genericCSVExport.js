import moment from 'moment';

export function exporttoCSVFile(dataArray, fileName) {
  if (dataArray && dataArray.length > 0) {
    const link = document.createElement('a');
    let csv = convertArrayOfObjectsToCSV(dataArray);
    if (csv == null) return;

    const filename = fileName + '_export.csv';

    if (!csv.match(/^data:text\/csv/i)) {
      csv = `data:text/csv;charset=utf-8,${csv}`;
    }

    link.setAttribute('href', encodeURI(csv));
    link.setAttribute('download', filename);
    link.click();
  }
}
function convertArrayOfObjectsToCSV(array) {
  let result;

  const columnDelimiter = ',';
  const lineDelimiter = '\n';
  const keys = Object.keys(array[0]);

  result = '';
  result += keys.join(columnDelimiter);
  result += lineDelimiter;

  array.forEach((item) => {
    let ctr = 0;
    keys.forEach((key) => {
      if (ctr > 0) result += columnDelimiter;

      result += item[key];

      ctr++;
    });
    result += lineDelimiter;
  });

  return result;
}

export function convertStartDateTime(value) {
  let dateTime = new Date(value);
  dateTime.setHours(0);
  dateTime.setMinutes(0);
  dateTime.setSeconds(0);
  let result = moment(dateTime).format('YYYY-MM-DD HH:mm:ss');
  return result;
}
export function convertEndDateTime(value) {
  let dateTime = new Date(value);
  dateTime.setHours(11);
  dateTime.setMinutes(59);
  dateTime.setSeconds(59);

  let result = moment(dateTime).format('YYYY-MM-DD HH:mm:ss');
  return result;
}

export function convertUtcToLocal(dateTime) {
  var date = moment.utc(dateTime).format('YYYY-MM-DD HH:mm:ss');
  var localTime = moment.utc(date).toDate();
  localTime = moment(localTime).format('YYYY-MM-DD HH:mm:ss');
  return localTime;
}

export function convertSeconds(sec) {
  var hrs = Math.floor(sec / 3600);
  var min = Math.floor((sec - hrs * 3600) / 60);
  var seconds = sec - hrs * 3600 - min * 60;
  seconds = Math.round(seconds * 100) / 100;

  var result = hrs < 10 ? '0' + hrs : hrs;
  result += ':' + (min < 10 ? '0' + min : min);
  result += ':' + (seconds < 10 ? '0' + seconds : seconds);
  return result;
}
