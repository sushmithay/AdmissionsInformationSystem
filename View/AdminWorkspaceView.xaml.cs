using System.Windows.Controls;
using System.Windows.Input;

namespace AdmissionsInformationSystem.View
{
	/// <summary>
	/// Interaction logic for AdminWorkspaceView.xaml
	/// </summary>
	public partial class AdminWorkspaceView : UserControl
	{
		public AdminWorkspaceView()
		{
			InitializeComponent();
		}

		private void TextBox_KeyDown(object sender, System.Windows.Input.KeyEventArgs e)
		{
			if(e.Key == Key.Return || e.Key == Key.Enter)
			{
				(sender as TextBox).MoveFocus(new TraversalRequest(FocusNavigationDirection.Next));
			}
		}
	}
}
