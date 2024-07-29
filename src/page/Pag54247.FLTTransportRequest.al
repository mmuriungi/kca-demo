page 54247 "FLT-Transport Request"
{
    PageType = Card;
    SourceTable = "FLT-Transport Requisition (B)";
    Caption = 'FLT-Transport Request';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("Officer No."; Rec."Officer No.")
                {
                    ApplicationArea = All;
                }
                field("Officer Name"; Rec."Officer Name")
                {
                    ApplicationArea = All;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                }
                field("Type of Vehicle"; Rec."Type of Vehicle")
                {
                    ApplicationArea = All;
                }
                field("Local Running"; Rec."Local Running")
                {
                    ApplicationArea = All;
                }
                field(Places; Rec.Places)
                {
                    ApplicationArea = All;
                }
                field("Estimated Period (Days)"; Rec."Estimated Period (Days)")
                {
                    ApplicationArea = All;
                }
                field("Journey Purpose"; Rec."Journey Purpose")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                }
                field("User Remarks"; Rec."User Remarks")
                {
                    ApplicationArea = All;
                }
                field("Transport Remarks"; Rec."Transport Remarks")
                {
                    ApplicationArea = All;
                }
                part(Control1102755016; "FLT-Transport Places")
                {
                    SubPageLink = "Request No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

