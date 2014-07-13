using AdmissionsInformationSystem.Patterns;
using System.ComponentModel;

namespace AdmissionsInformationSystem.Model
{
	public abstract class ViewModelBase : INotifyPropertyChanged, IWorkObject
	{
		public event PropertyChangedEventHandler PropertyChanged;

		protected void OnPropertyChanged(string name)
		{
			OnPropertyChanged(new PropertyChangedEventArgs(name));
		}

		protected virtual void OnPropertyChanged(PropertyChangedEventArgs e)
		{
			if(PropertyChanged != null)
			{
				PropertyChanged(this, e);
			}
		}

		public abstract void Save();
	}
}
