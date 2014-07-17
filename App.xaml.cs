using AdmissionsInformationSystem.Context;
using AdmissionsInformationSystem.Model;
using AdmissionsInformationSystem.ViewModel;
using System.Configuration;
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
		private IContext<CollegeLife> CollegeLife;
		private IContext<DegreeProgram> DegreePrograms;

		protected override void OnStartup(StartupEventArgs e)
		{
			base.OnStartup(e);
			if(ConfigurationManager.AppSettings["FakeData"] == "True")
			{
				Students = ModelGenerator.BuildFakeStudents();
				Parameters = ModelGenerator.BuildFakeParameters();
				CollegeLife = ModelGenerator.BuildFakeCollegeLife();
				DegreePrograms = ModelGenerator.BuildFakeDegreePrograms();
			}
			else
			{
				//connect with mysql database
				string connection = ConfigurationManager.ConnectionStrings["Database"].ConnectionString;

				Students = null;
				Parameters = null;
				CollegeLife = null;
				DegreePrograms = null;
			}

			MainWindowViewModel model = new MainWindowViewModel(Students, Parameters, CollegeLife, DegreePrograms);
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
