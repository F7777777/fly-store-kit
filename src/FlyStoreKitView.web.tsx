import * as React from 'react';

import { FlyStoreKitViewProps } from './FlyStoreKit.types';

export default function FlyStoreKitView(props: FlyStoreKitViewProps) {
  return (
    <div>
      <span>{props.name}</span>
    </div>
  );
}
