using System.Windows;
using System.Windows.Controls;
using AdmissionsInformationSystem.ViewModel;


namespace AdmissionsInformationSystem.View
{
    public partial class StudentApprovalsView : UserControl
    {
        public StudentApprovalsView()
        {
            InitializeComponent();
        }

        public void generate(object sender, RoutedEventArgs e)
        {

            var viewModel = DataContext as StudentApprovalsViewModel;
           // listBox.ItemsSource = viewModel.Students;
        }

    }
	
}
