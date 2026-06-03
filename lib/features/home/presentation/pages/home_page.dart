class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Good Morning, Alex", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const Text("Level 12  •  ⚡ 7 Day Streak", style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 30),
              const WorkoutCard(),
              const SizedBox(height: 20),
              _buildRecoveryScore(), // Recovery Card logic
              const SizedBox(height: 20),
              const XPProgressBar(currentXP: 2450, totalXP: 3000),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecoveryScore() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("RECOVERY SCORE", style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              Text("82", style: TextStyle(color: AppColors.primaryGreen, fontSize: 48, fontWeight: FontWeight.bold)),
              Text("Train Hard Today", style: TextStyle(color: Colors.white)),
            ],
          ),
          SizedBox(
            height: 80, width: 80,
            child: CircularProgressIndicator(
              value: 0.82,
              strokeWidth: 10,
              backgroundColor: AppColors.border,
              color: AppColors.primaryGreen,
            ),
          )
        ],
      ),
    );
  }
}