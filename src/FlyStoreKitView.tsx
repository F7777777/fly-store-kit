import { requireNativeViewManager } from 'expo-modules-core';
import * as React from 'react';

import { FlyStoreKitViewProps } from './FlyStoreKit.types';

const NativeView: React.ComponentType<FlyStoreKitViewProps> =
  requireNativeViewManager('FlyStoreKit');

export default function FlyStoreKitView(props: FlyStoreKitViewProps) {
  return <NativeView {...props} />;
}
