using AdmissionsInformationSystem.Context;
using AdmissionsInformationSystem.Model;
using AdmissionsInformationSystem.ViewModel;
using System.Windows;

namespace AdmissionsInformationSystem
{
	/// <summary>
	/// Interaction logic for App.xaml
	/// </summary>
	public partial class App : Application
	{
		private IStudentContext context;
		private static bool fakes = true;

		protected override void OnStartup(StartupEventArgs e)
		{
			base.OnStartup(e);
			if(fakes)
			{
				context = ModelGenerator.BuildFakes();
			}
			else
			{
				//connect with mysql database
				context = null;
			}

			MainWindowViewModel model = new MainWindowViewModel(context);
			MainWindow window = new MainWindow { DataContext = model };
			window.Show();
		}

		protected override void OnExit(ExitEventArgs e)
		{
			context.Dispose();
			base.OnExit(e);
		}
	}
}
