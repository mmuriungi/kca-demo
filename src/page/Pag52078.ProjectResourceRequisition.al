page 52078 "Project Resource Requisition"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Project Resource Requisition";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Project Req No"; Rec."Project Req No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Project Req No field.';
                    Editable = false;
                }
                field("Date Requested"; Rec."Date Requested")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Requested field.';
                }
                field(Researcher; Rec.Researcher)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Researcher field.';

                }
                field("Researcher Name"; Rec."Researcher Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Researcher Name field.';
                    Editable = false;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Code field.';
                    Editable = false;
                }
                field("School Code"; Rec."School Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the School Code field.';
                    Editable = false;
                }
                field(Specialization; Rec.Specialization)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Specialization field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }

            }
            group("Approvals")
            {
                field("Approval Information"; Rec."Approval Information")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approval Information field.';
                }
            }
            group(Project)
            {
                field("Main Project Objective"; Rec."Main Project Objective")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Main Project Objective field.';
                }
                field("Project Scope"; Rec."Project Scope")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Main Project Objective field.';
                }
                field("Project Duration"; Rec."Project Duration")
                {
                    ApplicationArea = All;
                    Caption = 'Project Duration(In Months)';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = ALL;
                }
            }
            part(ProjectReqLine; "Project Resource Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Project ReqNo" = field("Project Req No");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Attachments1)
            {
                ApplicationArea = All;
                Caption = 'Attachments';

                trigger OnAction()
                var
                    RecRef: RecordRef;
                    DocumentAttachment: Page "Document Attachment Custom";
                begin
                    Clear(DocumentAttachment);
                    RecRef.GETTABLE(Rec);
                    DocumentAttachment.OpenForRecReference(RecRef);
                    DocumentAttachment.RUNMODAL;
                end;
            }
            action("Research Publication")
            {
                ApplicationArea = All;
                RunObject = Page "Research Publications";
                RunPageLink = No = field("Project Req No");
            }

            action("Send for Approval")
            {
                ApplicationArea = All;
            }
        }
    }

    var
        hrEmp: Record "HRM-Employee C";
}