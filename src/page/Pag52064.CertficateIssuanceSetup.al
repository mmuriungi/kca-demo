page 52064 "Certificate Issuance Setup"
{
    ApplicationArea = All;
    Caption = 'Certificate Issuance Setup';
    PageType = Card;
    SourceTable = "Certificate Issuance Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Issuance Nos"; Rec."Issuance Nos")
                {
                    ToolTip = 'Specifies the value of the Cert Re-issuance Nos field.', Comment = '%';
                }
                field("Replacement Fee"; Rec."Replacement Fee")
                {
                    ToolTip = 'Specifies the value of the Replacement Fee field.', Comment = '%';
                }
                field("Storage Fee"; Rec."Storage Fee")
                {
                    ToolTip = 'Specifies the value of the Storage Fee field.', Comment = '%';
                }
                field("Storage Fee Frequency"; Rec."Storage Fee Frequency")
                {
                    ToolTip = 'Specifies the value of the Storage Fee Frequency field.', Comment = '%';
                }
                field("Transcript Pick-Up Duration"; Rec."Transcript Pick-Up Duration")
                {
                    ToolTip = 'Specifies the value of the Transcript Pick-Up Duration field.', Comment = '%';
                }
                field("Transcript Re-issuance Fee"; Rec."Transcript Re-issuance Fee")
                {
                    ToolTip = 'Specifies the value of the Transcript Re-issuance Fee field.', Comment = '%';
                }
                field("Replacement Fee Account"; Rec."Replacement Fee Account")
                {
                    ToolTip = 'Specifies the value of the Replacement Fee Account field.', Comment = '%';
                }
                field("Replacement Fees Account"; Rec."Replacement Fees Account")
                {
                    ToolTip = 'Specifies the value of the Replacement Fees Account field.', Comment = '%';
                }
                field("Storage Fees Account"; Rec."Storage Fees Account")
                {
                    ToolTip = 'Specifies the value of the Storage Fees Account field.', Comment = '%';
                }
                field("Transcript Re-issuance Fee Acc."; Rec."Transcript Re-issuance Fee Acc.")
                {
                    ToolTip = 'Specifies the value of the Transcript Re-issuance Fee Account field.', Comment = '%';
                }

            }
        }
    }
}
