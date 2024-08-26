page 50384 "HRM-Activity Employess"
{
    PageType = Worksheet;
    SourceTable = "HRM-Activity Employees";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Employee No"; Rec."Employee No")
                {

                    trigger OnValidate()
                    begin
                        Emp.Reset;
                        Emp.SetRange(Emp."No.", Rec."Employee No");
                        if Emp.Find('-') then begin
                            Rec."Full Names" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name"
                        end;
                    end;
                }
                field("Full Names"; Rec."Full Names")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        Emp: Record "HRM-Employee C";
}

