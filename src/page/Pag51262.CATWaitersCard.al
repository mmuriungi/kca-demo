page 51262 "CAT-Waiters Card"
{
    PageType = Card;
    SourceTable = "CAT-Waiters";

    layout
    {
        area(content)
        {
            group(General)
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

