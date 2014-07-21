using AdmissionsInformationSystem.Data;
using AdmissionsInformationSystem.Model;
using AdmissionsInformationSystem.ViewModel;
using System;
using System.Data;
using System.Data.OleDb;
using System.Windows;

namespace AdmissionsInformationSystem
{
	/// <summary>
	/// Interaction logic for MainWindow.xaml
	/// </summary>
	public partial class MainWindow : Window
	{
		public MainWindow()
		{
			InitializeComponent();
		}

		private void Button_Click(object sender, RoutedEventArgs e)
		{
			LoginViewModel model = new LoginViewModel();
			LoginWindow window = new LoginWindow { DataContext = model };
			window.OnLogin += Login;
			window.Show();
		}

		private void Login(object sender, EventArgs e)
		{
			LoginViewModel model = ((sender as LoginWindow).DataContext as LoginViewModel);
			DataTable result = Database.Proc("getLogin", new[] { 
				new OleDbParameter("userID", model.Username)
			});

			if(result != null && result.Rows.Count > 0)
			{
				DataRow user = result.Rows[0];
				if(user["isAdminFlag"].ToString() == "Yes")
				{
					Students.IsSelected = true;
					Inquire.Visibility = Visibility.Collapsed;
					Students.Visibility = Visibility.Visible;
					Approvals.Visibility = Visibility.Visible;
					Admin.Visibility = Visibility.Visible;
				}
				else
				{
					Inquire.IsSelected = true;
					Inquire.Visibility = Visibility.Visible;
					Students.Visibility = Visibility.Collapsed;
					Approvals.Visibility = Visibility.Collapsed;
					Admin.Visibility = Visibility.Collapsed;

					(DataContext as MainWindowViewModel).InquiryWorkspace.Student.UpdateModel(new Student(user));
				}
			}
		}
	}
}
