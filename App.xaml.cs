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
		private IContext<Student> Students;
		private IContext<Parameter> Parameters;
		private static bool fakes = true;

		protected override void OnStartup(StartupEventArgs e)
		{
			base.OnStartup(e);
			if(fakes)
			{
				Students = ModelGenerator.BuildFakeStudents();
				Parameters = ModelGenerator.BuildFakeParameters();
			}
			else
			{
				//connect with mysql database
				Students = null;
				Parameters = null;
			}

			MainWindowViewModel model = new MainWindowViewModel(Students, Parameters);
			MainWindow window = new MainWindow { DataContext = model };
			window.Show();
		}

		protected override void OnExit(ExitEventArgs e)
		{
			Students.Dispose();
			Parameters.Dispose();
			base.OnExit(e);
		}
	}
}
