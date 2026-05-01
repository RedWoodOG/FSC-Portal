class InventoryRisk {
  static int calculate(int currentQty, int weeklyUse, int minThreshold) {
    if (currentQty <= 0) return 100;
    if (currentQty < minThreshold) return 90;
    if (currentQty < weeklyUse) return 70;
    return 20;
  }

  static String getRiskLabel(int score) {
    if (score >= 90) return 'Critical';
    if (score >= 70) return 'Warning';
    if (score >= 40) return 'Low';
    return 'Healthy';
  }
}
