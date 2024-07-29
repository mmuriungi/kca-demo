table 54294 MeetingAtendees
{
    Caption = 'MeetingAtendees';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Meeting Code"; Code[20])
        {

        }
        field(2; "Pf No"; code[20])
        {
            TableRelation = "HRM-Employee C";
            trigger OnValidate()
            begin
                hrEmp.Reset();
                hrEmp.SetRange("No.", Rec."Pf No");
                if hrEmp.Find('-') then begin
                    Rec.FullNames := hrEmp."First Name" + ' ' + hrEmp."Middle Name" + ' ' + hrEmp."Last Name";
                    Rec.email := hrEmp."E-Mail";
                end;
                attend.Reset();
                attend.SetRange("Pf No", Rec."Pf No");
                if attend.Find('-') then begin
                    Error('STAFF HAS BEEN ALLOCATED TO ANOTHER MEETING!')
                end;
            end;
        }
        field(3; "FullNames"; Text[200])
        {

        }
        field(4; "Attendance Status"; Option)
        {
            OptionMembers = " ",Yes,No,Maybe,Apology;
        }
        field(5; "Apology Reason"; Code[20])
        {

        }
        field(6; email; text[50])
        {

        }



    }
    keys
    {
        key(PK; "Meeting Code", "Pf No")
        {
            Clustered = true;
        }
    }
    var
        hrEmp: Record "HRM-Employee C";
        attend: Record MeetingAtendees;
}
