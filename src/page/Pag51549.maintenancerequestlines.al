page 51549 "maintenance request lines"
{
    Caption = 'maintenance request lines';
    PageType = ListPart;
    SourceTable = "maintenance request lines";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("maintenance Requests"; Rec."maintenance Requests")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the maintenance Requests field.', Comment = '%';

                }
                field(description; Rec.description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the description field.', Comment = '%';
                }
                field(IsRepair; Rec.IsRepair)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the IsRepair field.', Comment = '%';
                }
                field(IsMaintenance; Rec.IsMaintenance)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the IsMaintenance field.', Comment = '%';
                }
                field(AssignedMo; Rec.AssignedMo)
                {
                    Caption = 'assigned MO';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the AssignedMo field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(email; Rec.email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the email field.', Comment = '%';
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Estimated Cost field.', Comment = '%';
                }
                field(timeline; Rec.timeline)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the timeline field.', Comment = '%';
                }
            }
        }
    }
}
