import { NativeModulesProxy, EventEmitter, Subscription } from 'expo-modules-core';

// Import the native module. On web, it will be resolved to FlyStoreKit.web.ts
// and on native platforms to FlyStoreKit.ts
import FlyStoreKitModule from './FlyStoreKitModule';
import FlyStoreKitView from './FlyStoreKitView';
import { ChangeEventPayload, FlyStoreKitViewProps } from './FlyStoreKit.types';

// Get the native constant value.
export const PI = FlyStoreKitModule.PI;

export function hello(): string {
  return FlyStoreKitModule.hello();
}

export async function setValueAsync(value: string) {
  return await FlyStoreKitModule.setValueAsync(value);
}

const emitter = new EventEmitter(FlyStoreKitModule ?? NativeModulesProxy.FlyStoreKit);

export function addChangeListener(listener: (event: ChangeEventPayload) => void): Subscription {
  return emitter.addListener<ChangeEventPayload>('onChange', listener);
}

export { FlyStoreKitView, FlyStoreKitViewProps, ChangeEventPayload };
