page 54226 "Service Gate Pass Card"
{
    PageType = Card;
    SourceTable = "Service Gate Pass";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Gate Pass No."; Rec."Gate Pass No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Time Out"; Rec."Time Out")
                {
                    ApplicationArea = All;
                }
                field("Job/Service No."; Rec."Job/Service No.")
                {
                    ApplicationArea = All;
                }
                field("Registration No."; Rec."Registration No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Chassis No."; Rec."Chassis No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Gear Box Code"; Rec."Gear Box Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Engine Code"; Rec."Engine Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Credit Approved"; Rec."Credit Approved")
                {
                    ApplicationArea = All;
                }
                field("Admit Code"; Rec."Admit Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Release)
            {
                Caption = 'Re&lease';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'Ctrl+F9';
                ApplicationArea = All;

                trigger OnAction()
                var
                    ReleasePurchDoc: Codeunit 415;
                begin
                    IF Rec.Type = Rec.Type::"Test Drive" THEN
                        ERROR(Text001) ELSE BEGIN
                        Rec.Status := Rec.Status::Released;
                        Rec."Released By" := USERID;
                        Rec."Released Date" := TODAY;
                        Rec."Released Time" := TIME;
                        Rec.MODIFY;
                    END;
                end;
            }
            action("Forward Test Drive for Approval")
            {
                Image = SendConfirmation;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.TESTFIELD(Type, Rec.Type::"Test Drive");
                    Rec.Status := Rec.Status::"Pending Approval";
                    Rec.MODIFY;
                end;
            }
        }
    }

    var
        GatePass: Record "Service Gate Pass";
        Text001: Label 'Test Drive Gate Pass must first be forwarded for approval';
}

