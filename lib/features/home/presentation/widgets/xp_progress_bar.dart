class XPProgressBar extends StatelessWidget {
  final int currentXP;
  final int totalXP;
  const XPProgressBar({super.key, required this.currentXP, required this.totalXP});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("LEVEL PROGRESS", style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            Text("$currentXP / $totalXP XP", style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: currentXP / totalXP,
          backgroundColor: AppColors.border,
          color: AppColors.primaryGreen,
          minHeight: 10,
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }
}