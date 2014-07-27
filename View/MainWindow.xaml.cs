using AdmissionsInformationSystem.Data;
using AdmissionsInformationSystem.Model;
using AdmissionsInformationSystem.ViewModel;
using MySql.Data.MySqlClient;
using System;
using System.Data;
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

			Inquire.IsSelected = true;
			Inquire.Visibility = Visibility.Visible;
			Students.Visibility = Visibility.Collapsed;
			Approvals.Visibility = Visibility.Collapsed;
			Admin.Visibility = Visibility.Collapsed;
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

			try
			{
				DataTable result = Database.Proc("getLogin", new[] { 
					new MySqlParameter("IN_userID", Convert.ToInt32(model.Username)),
					new MySqlParameter("IN_passwd", model.Password)
				});

				if(result != null && result.Rows.Count > 0)
				{
					MainWindowViewModel window = (DataContext as MainWindowViewModel);
					DataRow user = result.Rows[0];
					if(result.Columns.Contains("admissionClerkID"))
					{
						Students.IsSelected = true;
						Inquire.Visibility = Visibility.Collapsed;
						Students.Visibility = Visibility.Visible;
						Approvals.Visibility = Visibility.Visible;

						if(Convert.ToInt32(user["admissionClerkID"]) == 1)
						{
							Admin.Visibility = Visibility.Visible;
						}
						else
						{
							Admin.Visibility = Visibility.Collapsed;
						}

						window.Welcome = "Welcome, " + user["fName"] + "!";
					}
					else
					{
						Inquire.IsSelected = true;
						Inquire.Visibility = Visibility.Visible;
						Students.Visibility = Visibility.Collapsed;
						Approvals.Visibility = Visibility.Collapsed;
						Admin.Visibility = Visibility.Collapsed;

						window.InquiryWorkspace.Student.UpdateModel(new Student(user));
						window.Welcome = "Welcome, " + user["fName"] + "!";
					}
				}
				else
				{
					MessageBox.Show("Invalid username or password");
				}
			}
			catch
			{
				MessageBox.Show("Invalid username or password");
			}
		}
	}
}
