using System;
using System.Windows;

namespace AdmissionsInformationSystem
{
	/// <summary>
	/// Interaction logic for LoginWindow.xaml
	/// </summary>
	public partial class LoginWindow : Window
	{
		public event EventHandler OnLogin;

		public LoginWindow()
		{
			InitializeComponent();
		}

		private void Button_Click(object sender, RoutedEventArgs e)
		{
			this.Close();
		}

		private void Button_Click_1(object sender, RoutedEventArgs e)
		{
			if(OnLogin != null)
			{
				OnLogin(this, null);
			}
			this.Close();
		}
	}
}
