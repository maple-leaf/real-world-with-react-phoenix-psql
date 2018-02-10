import * as React from 'react';
import { storiesOf } from '@storybook/react';
import { action } from '@storybook/addon-actions';
import { Logo } from './index.tsx';

storiesOf('Logo', module)
.add('plain text', () => (
    <Logo />
));
