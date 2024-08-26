page 51249 "CAT-Transfer Order Sub."
{
    AutoSplitKey = true;
    Caption = 'Transfer Order Subform';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Transfer Line";

    layout
    {
        area(content)
        {
            repeater(tr)
            {
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                }
                field("Planning Flexibility"; Rec."Planning Flexibility")
                {
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Transfer-from Bin Code"; Rec."Transfer-from Bin Code")
                {
                    Visible = false;
                }
                field("Transfer-To Bin Code"; Rec."Transfer-To Bin Code")
                {
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    Editable = false;
                }
                field("Reserved Quantity Inbnd."; Rec."Reserved Quantity Inbnd.")
                {
                    BlankZero = true;
                }
                field("Reserved Quantity Shipped"; Rec."Reserved Quantity Shipped")
                {
                    BlankZero = true;
                }
                field("Reserved Quantity Outbnd."; Rec."Reserved Quantity Outbnd.")
                {
                    BlankZero = true;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Visible = false;
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    BlankZero = true;
                    Editable = false;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    BlankZero = true;

                    trigger OnDrillDown()
                    var
                        TransShptLine: Record "Transfer Shipment Line";
                    begin
                        Rec.TESTFIELD("Document No.");
                        Rec.TESTFIELD("Item No.");
                        TransShptLine.SETCURRENTKEY("Transfer Order No.", "Item No.", "Shipment Date");
                        TransShptLine.SETRANGE("Transfer Order No.", Rec."Document No.");
                        TransShptLine.SETRANGE("Item No.", Rec."Item No.");
                        PAGE.RUNMODAL(0, TransShptLine);
                    end;
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    BlankZero = true;

                    trigger OnValidate()
                    begin
                        IF Rec."Qty. to Receive (Base)" > Rec."Quantity Shipped" THEN BEGIN
                            ERROR('You Can Not Receive More Than Shipped Quantity')
                        END;
                    end;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    BlankZero = true;

                    trigger OnDrillDown()
                    var
                        TransRcptLine: Record "Transfer Receipt Line";
                    begin
                        Rec.TESTFIELD("Document No.");
                        Rec.TESTFIELD("Item No.");
                        TransRcptLine.SETCURRENTKEY("Transfer Order No.", "Item No.", "Receipt Date");
                        TransRcptLine.SETRANGE("Transfer Order No.", Rec."Document No.");
                        TransRcptLine.SETRANGE("Item No.", Rec."Item No.");
                        PAGE.RUNMODAL(0, TransRcptLine);
                    end;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                // field(ShortcutDimCode3;short)
                // {
                //     CaptionClass = '1,2,3';
                //     Visible = false;

                //     trigger OnLookup(var Text: Text): Boolean
                //     begin
                //         LookupShortcutDimCode(3,ShortcutDimCode[3]);
                //     end;

                //     trigger OnValidate()
                //     begin
                //         ValidateShortcutDimCode(3,ShortcutDimCode[3]);
                //     end;
                // }
                // field(ShortcutDimCode[4];ShortcutDimCode[4])
                // {
                //     CaptionClass = '1,2,4';
                //     Visible = false;

                //     trigger OnLookup(var Text: Text): Boolean
                //     begin
                //         LookupShortcutDimCode(4,ShortcutDimCode[4]);
                //     end;

                //     trigger OnValidate()
                //     begin
                //         ValidateShortcutDimCode(4,ShortcutDimCode[4]);
                //     end;
                // }
                // field(ShortcutDimCode[5];ShortcutDimCode[5])
                // {
                //     CaptionClass = '1,2,5';
                //     Visible = false;

                //     trigger OnLookup(var Text: Text): Boolean
                //     begin
                //         LookupShortcutDimCode(5,ShortcutDimCode[5]);
                //     end;

                //     trigger OnValidate()
                //     begin
                //         ValidateShortcutDimCode(5,ShortcutDimCode[5]);
                //     end;
                // }
                // field(ShortcutDimCode[6];ShortcutDimCode[6])
                // {
                //     CaptionClass = '1,2,6';
                //     Visible = false;

                //     trigger OnLookup(var Text: Text): Boolean
                //     begin
                //         LookupShortcutDimCode(6,ShortcutDimCode[6]);
                //     end;

                //     trigger OnValidate()
                //     begin
                //         ValidateShortcutDimCode(6,ShortcutDimCode[6]);
                //     end;
                // }
                // field(ShortcutDimCode[7];ShortcutDimCode[7])
                // {
                //     CaptionClass = '1,2,7';
                //     Visible = false;

                //     trigger OnLookup(var Text: Text): Boolean
                //     begin
                //         LookupShortcutDimCode(7,ShortcutDimCode[7]);
                //     end;

                //     trigger OnValidate()
                //     begin
                //         ValidateShortcutDimCode(7,ShortcutDimCode[7]);
                //     end;
                // }
                // field(ShortcutDimCode[8];ShortcutDimCode[8])
                // {
                //     CaptionClass = '1,2,8';
                //     Visible = false;

                //     trigger OnLookup(var Text: Text): Boolean
                //     begin
                //         LookupShortcutDimCode(8,ShortcutDimCode[8]);
                //     end;

                //     trigger OnValidate()
                //     begin
                //         ValidateShortcutDimCode(8,ShortcutDimCode[8]);
                //     end;
                // }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CLEAR(ShortcutDimCode);
    end;

    var
        ShortcutDimCode: array[8] of Code[20];

    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;

    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location)
    begin
    end;

    procedure ShowReservation()
    begin
        Rec.FIND;
        Rec.ShowReservation;
    end;

    procedure OpenItemTrackingLines(Direction: Option Outbound,Inbound)
    begin
        Rec.OpenItemTrackingLines(Direction);
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;
}

