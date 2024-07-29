page 54389 "Maintenance Requests"
{
    Caption = 'Maintenance Requests';
    PageType = List;
    SourceTable = "Maintenance Request";
    CardPageId = "Maintenance Request";
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Facility No."; Rec."Facility No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Facility No. field.';
                }
                field("Facility Description"; Rec."Facility Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Facility Description field.';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Request Date field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the E-Mail field.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field("Maintenance Description"; Rec."Maintenance Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maintenance Description field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Maintenance Period"; Rec."Maintenance Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maintenance Period(Days) field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Type Of Request"; Rec."Type Of Request")
                {
                    Caption = 'Type Of Request';
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
                    Editable = false;

                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(email; Rec.email)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the email field.', Comment = '%';
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Estimated Cost field.', Comment = '%';
                }
                field("Estates Officer"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }

            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false;
    end;
}
