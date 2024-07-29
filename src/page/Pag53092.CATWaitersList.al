page 53092 "CAT-Waiters List"
{
    CardPageID = "CAT-Waiters Card";
    Editable = false;
    PageType = List;
    SourceTable = "CAT-Waiters";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Category; Rec.Category)
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field(empname; emplName)
                {
                    Caption = 'Employee Name';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IF emp.GET(Rec."Employee No.") THEN BEGIN
            emplName := emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
        END;
    end;

    var
        emplName: Text[250];
        emp: Record "HRM-Employee C";
}

