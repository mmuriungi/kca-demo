page 51537 "maintenance request list"
{
    Caption = 'maintenance request list';
    Editable = false;
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Maintenance Officer";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Completed; Rec.Completed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completed field.', Comment = '%';
                }
                field("Completion FeedBack"; Rec."Completion FeedBack")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion FeedBack field.', Comment = '%';
                }
                field("Date Assigned"; Rec."Date Assigned")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Assigned field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the E-Mail field.';
                }
                field("Estimated End Date"; Rec."Estimated End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Estimated End Date field.', Comment = '%';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.', Comment = '%';
                }
                field("Officer Name"; Rec."Officer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Officer Name field.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field("Repair Feedback"; Rec."Repair Feedback")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Repair Feedback field.', Comment = '%';
                }
                field("Repair No."; Rec."Repair No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Repair No. field.', Comment = '%';
                }
                field("Repair Period"; Rec."Repair Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Repair Period(Days) field.', Comment = '%';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("client Closed"; Rec."client Closed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the client Closed field.', Comment = '%';
                }
                field("client feedback"; Rec."client feedback")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the client feedback field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
            }
        }
    }
}
