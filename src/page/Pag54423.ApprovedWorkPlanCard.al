page 54423 "Approved WorkPlan Card"
{
    Caption = 'Approved WorkPlan Card';
    PageType = Card;
    SourceTable = "DepartMent Work Plan";
    Editable = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Department; Rec.Department)
                {

                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("Department Name"; Rec."Department Name")
                {

                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Name field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Incharge; Rec.Incharge)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Incharge field.';
                    Editable = false;
                }
                field("Plan Year"; Rec."Plan Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Plan Year field.';
                }

            }
            part(Line; "Departmental Activities1")
            {
                UpdatePropagation = Both;
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(52413),
                              "No." = FIELD("No.");
            }
            systempart(Link; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Note; Notes)
            {
                ApplicationArea = Notes;
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action("Notify Staff")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SendTo;
                trigger OnAction()
                var
                    Employee: Record "HRM-Employee (D)";
                    Recipients: list of [Text];
                    EmailMessage: Codeunit "Email Message";
                    Email: Codeunit Email;
                    Body: Text;
                    StaffName: Text;
                    WorkPlanHeader: Record "DepartMent Work Plan";
                begin
                    Employee.SetRange("Department Code", Rec.Department);
                    if Employee.FindSet(true, true) then begin
                        repeat
                            Recipients.Add(Employee."Company E-Mail");
                            StaffName := Employee.FullName();
                        until Employee.Next() = 0
                    end;
                    Body := StrSubstNo('Dear %1 <br> Kindly check at the department workplan No. %2 in the system and use it to create your targets for the year <br>Kind Regard HOD ', StaffName, Rec."No.");
                    EmailMessage.Create(Recipients, 'Department Workplan Notice', Body, true);
                    email.Send(EmailMessage, enum::"Email Scenario"::Default);
                    Message('All Staffs in this department have been notified on mail');

                end;
            }
        }

    }
}
