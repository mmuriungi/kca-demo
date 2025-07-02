table 52178574 "Proc Bidder Quoted Amounts"
{
    LookupPageId = "Proc Bidder Quoted Amounts";
    DrillDownPageId = "Proc Bidder Quoted Amounts";
    Caption = 'Proc Bidder Quoted Amounts';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No"; Code[20])
        {
            Editable = false;
            Caption = 'Document No';
            /* DrillDownPageId = "Proc-Purchase Quot Req. Header";
            Editable = false;
            ApplicationArea = All;
            ToolTip = 'Specifies the value of the No. field.';
            trigger OnDrillDown()
            var
                Pheader: Record "Proc-Purchase Quote Header";
            begin
                Pheader.Reset();
                Pheader.SetRange("No.", rec."No.");
                if Pheader.Find('-') then
                    page.run(page::"Proc-Purchase Quote.Card", Pheader)
            end; */
        }
        field(2; "Bid No"; Code[30])
        {
            Editable = false;
            Caption = 'Bid No';

        }
        field(3; "Item No"; Code[30])
        {
            Editable = false;
            Caption = 'Item No';
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST("G/L Account")) "G/L Account"."No." where(Blocked = filter(false), "Account Type" = filter(Posting), "Direct Posting" = filter(true))
            ELSE
            IF (Type = CONST(Item)) Item where(Blocked = filter(false))
            ELSE
            IF (Type = CONST(Resource)) Resource
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset" where(Blocked = filter(false))
            ELSE
            IF (Type = CONST("Charge (Item)")) "Item Charge";

            trigger OnValidate()

            begin

                IF Type = Type::"G/L Account" THEN BEGIN
                    GLAcc.RESET;
                    GLAcc.GET("Item No");
                    "Item Description" := GLAcc.Name;
                END
                ELSE
                    IF Type = Type::Item THEN BEGIN
                        Item.RESET;
                        Item.GET("Item No");
                        "Item Description" := Item.Description;
                    END
                    ELSE
                        IF Type = Type::"Fixed Asset" THEN BEGIN
                            FA.RESET;
                            FA.GET("Item No");
                            "Item Description" := FA.Description;
                        END
                        ELSE
                            IF Type = Type::"Charge (Item)" THEN BEGIN
                                CItem.RESET;
                                CItem.GET("Item No");
                                "Item Description" := CItem.Description;
                            END;
            end;
        }
        field(4; "Supplier No"; Code[30])
        {
            Editable = false;
            Caption = 'Supplier No';
            TableRelation = Vendor;
            trigger OnValidate()
            begin
                Vend.Reset();
                Vend.SetRange("No.", "Supplier No");
                if Vend.Find('-') then
                    "Supplier Name" := Vend.Name;
            end;

        }
        field(5; "Type"; Enum "Purchase Line Type")
        {
            Caption = 'Type';
        }
        field(6; "Procurement Method"; Enum "Proc-Procurement Methods")
        {
            Caption = 'Procurement Method';
        }
        field(7; "Supplier Name"; Text[250])
        {
            Caption = 'Supplier Name';
            Editable = false;
        }
        field(8; Quantity; Integer)
        {
            Editable = false;
            Caption = 'Quantity';
            trigger OnValidate()
            begin
                Amount := Quantity * "Unit Cost";
            end;

        }
        field(9; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            trigger OnValidate()
            begin
                Amount := Quantity * "Unit Cost";
            end;
        }
        field(10; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
        }
        field(11; "Item Description"; Text[250])
        {
            Caption = 'Item Description';
            Editable = false;
        }
        field(12; Select; Boolean)
        {

        }
        field(13; "Order No"; Code[50])
        {

        }
        field(14; "Entry No"; Integer)
        {

        }
    }
    keys
    {
        key(PK; "Document No", "Bid No", "Item No", "Entry No", "Supplier No")
        {
            Clustered = true;
        }
        key(key2; "Supplier No")
        {

        }
    }
    var
        ICPartner: Record "IC Partner";
        ItemCrossReference: Record "Item Reference";
        PrepmtMgt: Codeunit "Prepayment Mgt.";
        GLAcc: Record "G/L Account";
        Item: Record Item;
        fa: Record "Fixed Asset";
        CItem: Record "Item Charge";
        Vend: Record Vendor;

    trigger OnInsert()
    begin
        if "Entry No" = 0 then
            "Entry No" := GetLastEntryNo() + 1;
    end;

    procedure GetLastEntryNo(): Integer;
    var
        FindRecordManagement: Codeunit "Find Record Management";
    begin
        exit(FindRecordManagement.GetLastEntryIntFieldValue(Rec, FieldNo("Entry No")))
    end;
}
