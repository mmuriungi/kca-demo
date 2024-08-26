page 51522 "Maintenance Schedule ListPart"
{
    Caption = 'Schedule Lines';
    PageType = ListPart;
    SourceTable = "Maintenance Schedule Line";
    SourceTableView = where("Repair Request Generated" = const(false));
    CardPageId = "Repair Request";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Request No."; Rec."Request No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Request No. field.';
                }
                field("Facility Description"; rec."Facility Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Request Description field.';
                }
                field("Request Description"; Rec."maintenance Requests")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Request Description field.';
                }
                field("Requester Name"; rec."Requester Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Request Description field.';
                }
                field("Department Code"; rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Request Description field.';
                }
                field(AssignedMo; rec.AssignedMo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Request Description field.';
                }
                field("Maintenance Period"; rec."Maintenance Period")
                {
                    ApplicationArea = all;
                }
                field("Maintenance Year"; rec."Maintenance Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Request Description field.';
                }
                field("Estimated Cost"; rec."Estimated Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Request Description field.';
                }
                // field("Maintenance Officers"; Rec."Maintenance Officers")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Maintenance Officers field.';
                // }
                // field("Requested Items/Assets"; Rec."Requested Items/Assets")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Requested Items/Assets field.';
                // }
                // field("E-Mail"; Rec."E-Mail")
                // {
                //     ApplicationArea = Basic, Suite;
                //     ShowMandatory = true;
                // }
                // field(Notified; Rec.Notified)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("maintenance status"; rec."maintenance status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                // field("Expected Start Date"; Rec."Expected Start Date")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Expected Start Date field.';
                // }
                // field("Expected End Date"; Rec."Expected End Date")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Expected End Date field.';
                // }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Generate Repair Request")
            {
                Image = ItemAvailabilitybyPeriod;
                ApplicationArea = Basic, Suite;
                trigger OnAction()
                begin
                    EstatesMgnt.PopulateRepairRequest(Rec."Request No.");
                end;
            }
        }
    }
    var
        EstatesMgnt: Codeunit "Estates Management";
}





