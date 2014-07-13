﻿using AdmissionsInformationSystem.Context;
using AdmissionsInformationSystem.Model;
using AdmissionsInformationSystem.Patterns;
using System;
using System.Windows.Input;

namespace AdmissionsInformationSystem.ViewModel
{
	public class MainWindowViewModel : ViewModelBase
	{
		public InquiryWorkspaceViewModel InquiryWorkspace { get; private set; }
		public StudentWorkspaceViewModel StudentWorkspace { get; private set; }
		public AdminWorkspaceViewModel AdminWorkspace { get; private set; }

		private IStudentContext context;

		public MainWindowViewModel(IStudentContext context)
		{
			if(context == null)
			{
				throw new ArgumentNullException("context");
			}

			this.context = context;

			InquiryWorkspace = new InquiryWorkspaceViewModel();
			StudentWorkspace = new StudentWorkspaceViewModel();
			AdminWorkspace = new AdminWorkspaceViewModel();

			SaveCommand = new DelegateCommand(o => Save());
			LoginCommand = new DelegateCommand(o => Login());
		}

		public ICommand SaveCommand { get; private set; }
		public ICommand LoginCommand { get; private set; }

		public override void Save()
		{
			context.Save();
		}

		public void Login()
		{

		}
	}
}
