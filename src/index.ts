import FlyStoreKitModule from './FlyStoreKitModule';
import {Alert} from "react-native";

export async function beginRefundRequest(productID: string): Promise<void> {
  try {
    await FlyStoreKitModule.beginRefundRequest(productID);
  } catch (e) {
    Alert.alert('', "This feature is not available now. Please try again later or contact us. ")
  }
}

export async function showManageSubscriptions(): Promise<void> {
  try {
    await FlyStoreKitModule.showManageSubscriptions();
  } catch (e) {
    Alert.alert('', "This feature is not available now. Please try again later or contact us. ")
  }
}

