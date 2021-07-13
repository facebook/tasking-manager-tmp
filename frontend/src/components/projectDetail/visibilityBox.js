import { FormattedMessage } from 'react-intl';

import { LockIcon } from '../svgIcons';
import messages from './messages';

export const ProjectVisibilityBox = ({ className }: Object) => {
  return (
    <div className={`tc br1 f7 ttu ba b--primary primary ${className}`}>
      <LockIcon title="lock" className="primary v-mid mr1" style={{ height: '13px', width: '13px' }} />
      <FormattedMessage {...messages.private} />
    </div>
  );
};
