using AdmissionsInformationSystem.Context;
using AdmissionsInformationSystem.Model;
using AdmissionsInformationSystem.Patterns;
using System;
using System.Windows;
using System.Windows.Input;

namespace AdmissionsInformationSystem.ViewModel
{
	public class InquiryWorkspaceViewModel : ViewModelBase
	{
		private IContext<Student> context;
		private StudentViewModel student;

		public InquiryWorkspaceViewModel(IContext<Student> context)
		{
			if(context == null)
			{
				throw new ArgumentNullException("context");
			}

			this.context = context;

			student = new StudentViewModel(context.Create(), context);

			InquireCommand = new DelegateCommand(o => Inquire());
			ApplyCommand = new DelegateCommand(o => Apply());
		}

		public ICommand InquireCommand { get; private set; }
		public ICommand ApplyCommand { get; private set; }

		private void Inquire()
		{
			MessageBox.Show("Inquiry Email");
			Save();
		}

		private void Apply()
		{
			MessageBox.Show("Application Email");
			Save();
		}

		public override void Save()
		{
			student.Save();
		}
	}
}
