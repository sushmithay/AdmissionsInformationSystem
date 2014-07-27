using AdmissionsInformationSystem.Context;
using AdmissionsInformationSystem.Data;
using AdmissionsInformationSystem.Model;
using AdmissionsInformationSystem.ViewModel;
using System.Collections.ObjectModel;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Windows;

namespace AdmissionsInformationSystem
{
	/// <summary>
	/// Interaction logic for App.xaml
	/// </summary>
	public partial class App : Application
	{
		private StudentContext Students;
		private ParameterContext Parameters;

		protected override void OnStartup(StartupEventArgs e)
		{
			base.OnStartup(e);

			ObservableCollection<CollegeLife> collegeLife;
			ObservableCollection<DegreeProgram> degreePrograms;
			ObservableCollection<Term> terms;

			try
			{
				//connect with mysql database
				Database.ConnectionString = ConfigurationManager.ConnectionStrings["Database"].ConnectionString;

				Students = new StudentContext(
					from DataRow row in Database.Query("SELECT * FROM ais.tblstudent").Rows
					select new Student(row));

				Parameters = new ParameterContext(
					from DataRow row in Database.Query("SELECT * FROM ais.tblparameter").Rows
					select new Parameter(row));

				collegeLife = new ObservableCollection<CollegeLife>(
					from DataRow row in Database.Proc("getPersonalInterest").Rows
					select new CollegeLife(row));

				degreePrograms = new ObservableCollection<DegreeProgram>(
					from DataRow row in Database.Proc("getDegreePrograms").Rows
					select new DegreeProgram(row));

				terms = new ObservableCollection<Term>(
					from DataRow row in Database.Proc("getTerm").Rows
					select new Term(row));
			}
			catch
			{
				Students = ModelGenerator.BuildFakeStudents();
				Parameters = ModelGenerator.BuildFakeParameters();
				collegeLife = ModelGenerator.BuildFakeCollegeLife();
				degreePrograms = ModelGenerator.BuildFakeDegreePrograms();
				terms = null;
			}

			MainWindowViewModel model = new MainWindowViewModel(Students, Parameters, collegeLife, degreePrograms, terms);
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
