import FlyStoreKitModule from './FlyStoreKitModule';

export function hello(): string {
  return FlyStoreKitModule.hello();
}

export async function beginRefundRequest(productID: string) {
  return await FlyStoreKitModule.beginRefundRequest(productID);
}

export async function showManageSubscriptions() {
  return await FlyStoreKitModule.showManageSubscriptions();
}

