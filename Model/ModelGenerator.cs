using AdmissionsInformationSystem.Context;
using System.Collections.Generic;

namespace AdmissionsInformationSystem.Model
{
	public static class ModelGenerator
	{
		public static FakeStudentContext BuildFakes()
		{
			return new FakeStudentContext(
				new List<Student>() {
					new Student() { Id = 1 },
					new Student() { Id = 2 },
					new Student() { Id = 3 },
					new Student() { Id = 4 }
				}
			);
		}
	}
}
