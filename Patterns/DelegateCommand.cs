using System;
using System.Windows.Input;

namespace AdmissionsInformationSystem.Patterns
{
	public class DelegateCommand : ICommand
	{
		private Action<object> action;

		public DelegateCommand(Action<object> action)
		{
			if(action == null)
			{
				throw new ArgumentNullException("action");
			}

			this.action = action;
		}

		public bool CanExecute(object parameter)
		{
			return true;
		}

		public event EventHandler CanExecuteChanged;

		public void Execute(object parameter)
		{
			action(parameter);
		}
	}
}
