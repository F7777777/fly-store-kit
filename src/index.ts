import FlyStoreKitModule from './FlyStoreKitModule';

export function hello(): string {
  return FlyStoreKitModule.hello();
}

export async function setValueAsync(value: string) {
  return await FlyStoreKitModule.setValueAsync(value);
}

