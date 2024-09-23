table 51300 "Postgrad Activities Cue"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; PrimaryKey; Code[10])
        {
            DataClassification = SystemMetadata;
        }
        field(2; ActiveStudents; Integer)
        {
            CalcFormula = Count(Customer where("Customer Type" = const(Student)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; PendingApplications; Integer)
        {
            CalcFormula = Count("Postgrad Supervisor Applic." where(Status = const(Pending)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; RecentSubmissions; Integer)
        {
            CalcFormula = Count("Student Submission" where("Submission Date" = field(DateFilter)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; ActiveSupervisors; Integer)
        {
            CalcFormula = Count("HRM-Employee C" where(Lecturer = const(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; SubmissionsToReview; Integer)
        {
            CalcFormula = Count("Student Submission" where(Status = const(Pending)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; DateFilter; Date)
        {
            Caption = 'Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(PK; PrimaryKey)
        {
            Clustered = true;
        }
    }

    procedure CalculateCueFieldValues()
    begin
        Rec.SetRange(DateFilter, CalcDate('<-30D>', Today), Today);
    end;
}
