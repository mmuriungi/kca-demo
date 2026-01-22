table 52178793 "Tender Applicants Registration"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    PurchSetup.Get();
                    NoSeriesMgt.TestManual(PurchSetup."Vendor Nos.");
                    "No. Series" := '';
                end;

            end;
        }
        field(2; Name; Text[250])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
                    "Search Name" := Name;
            end;
        }
        field(3; "Search Name"; Code[250])
        {
            Caption = 'Search Name';
        }
        field(4; "Name 2"; Text[100])
        {
            Caption = 'Name 2';
        }
        field(5; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(6; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code".City
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;


        }
        field(8; Contact; Text[100])
        {
            Caption = 'Contact';


        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;


        }

        field(10; "Telex No."; Text[20])
        {
            Caption = 'Telex No.';
        }
        field(11; "Contact Person"; Text[100])
        {

        }
        field(12; "Contact Person Email"; Text[100])
        {

        }
        field(13; "Certificate of Incoporation"; Text[250])
        {

        }
        field(14; "Our Account No."; Text[20])
        {
            Caption = 'Our Account No.';
        }
        field(15; "Pin Registration Certificate"; Text[250])
        {

        }

        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));


        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(18; "VAT Registration Certificate"; Text[250])
        {

        }
        field(19; "Tax Compliance Certificate"; Text[250])
        {

        }

        field(20; "Vendor Posting Group"; Code[20])
        {
            Caption = 'Vendor Posting Group';
            TableRelation = "Vendor Posting Group";
        }
        field(21; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(22; "Company Contact"; text[100])
        {

        }
        field(23; "Company Email"; text[100])
        {

        }
        field(24; "Vendor No."; Code[30])
        {
            Editable = false;
        }


        field(25; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";

        }
        field(26; Comment; Boolean)
        {
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST(Vendor),
                                                      "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; Blocked; Enum "Vendor Blocked")
        {
            Caption = 'Blocked';

            trigger OnValidate()
            begin
                if (Blocked <> Blocked::All) and "Privacy Blocked" then
                    if GuiAllowed then
                        if Confirm(ConfirmBlockedPrivacyBlockedQst) then
                            "Privacy Blocked" := false
                        else
                            Error('')
                    else
                        Error(CanNotChangeBlockedDueToPrivacyBlockedErr);
            end;
        }

        field(28; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

        }
        field(29; "Last Modified Date Time"; DateTime)
        {
            Caption = 'Last Modified Date Time';
            Editable = false;
        }
        field(30; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(31; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(32; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(33; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(34; Balance; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor No." = FIELD("No."),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }

        field(35; "Application Method"; Enum "Application Method")
        {
            Caption = 'Application Method';
        }
        field(36; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';
        }
        field(37; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }

        field(38; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';

            trigger OnValidate()
            begin
                "VAT Registration No." := UpperCase("VAT Registration No.");
            end;
        }
        field(39; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate()
            begin
                if xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" then
                    if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp, "Gen. Bus. Posting Group") then
                        Validate("VAT Bus. Posting Group", GenBusPostingGrp."Def. VAT Bus. Posting Group");
            end;
        }
        field(40; Picture; BLOB)
        {
            Caption = 'Picture', Locked = true;
            ObsoleteReason = 'Replaced by Image field';
            ObsoleteState = Removed;
            SubType = Bitmap;
            ObsoleteTag = '18.0';
        }

        field(41; County; Text[30])
        {
            CaptionClass = '5,1,' + "Country/Region Code";
            Caption = 'County';
        }

        field(42; "Password"; text[80])
        {
            // ExtendedDatatype = Masked;
        }
        field(43; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            //ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                if "E-Mail" = '' then
                    exit;
                //MailManagement.CheckValidEmailAddresses("E-Mail");
            end;
        }
        field(44; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
            ExtendedDatatype = URL;
        }
        field(45; "Changed Password"; Boolean)
        {

        }

        field(46; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }

        field(47; "VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(48; "Currency Filter"; Code[10])
        {
            Caption = 'Currency Filter';
            FieldClass = FlowFilter;
            TableRelation = Currency;
        }

        field(49; "Partner Type"; Enum "Partner Type")
        {
            Caption = 'Partner Type';
        }
        field(50; Image; Media)
        {
            Caption = 'Image';
            ExtendedDatatype = Person;
        }
        field(51; "Privacy Blocked"; Boolean)
        {
            Caption = 'Privacy Blocked';

            trigger OnValidate()
            begin
                if "Privacy Blocked" then
                    Blocked := Blocked::All
                else
                    Blocked := Blocked::" ";
            end;
        }
        field(52; OTP; Code[20])
        {

        }
        field(53; "Account Activated"; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name, City, "Phone No.", Contact)
        {
        }
        fieldgroup(Brick; "No.", Name, Image)
        {
        }
    }



    var
        Text000: Label 'You cannot delete %1 %2 because there is at least one outstanding Purchase %3 for this vendor.';
        Text003: Label 'Do you wish to create a contact for %1 %2?';
        PurchSetup: Record "Purchases & Payables Setup";
        CommentLine: Record "Comment Line";
        PostCode: Record "Post Code";
        VendBankAcc: Record "Vendor Bank Account";
        OrderAddr: Record "Order Address";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        RMSetup: Record "Marketing Setup";
        ServiceItem: Record "Service Item";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        CustomizedCalendarChange: Record "Customized Calendar Change";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MoveEntries: Codeunit MoveEntries;
        UpdateContFromVend: Codeunit "VendCont-Update";
        DimMgt: Codeunit DimensionManagement;
        LeadTimeMgt: Codeunit "Lead-Time Management";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CalendarManagement: Codeunit "Calendar Management";
        InsertFromContact: Boolean;
        Text004: Label 'Contact %1 %2 is not related to vendor %3 %4.';
        Text005: Label 'post';
        Text006: Label 'create';
        Text007: Label 'You cannot %1 this type of document when Vendor %2 is blocked with type %3';
        Text008: Label 'The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3.';
        Text009: Label 'Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?';
        Text010: Label 'You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.';
        Text011: Label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        Text10000: Label '%1 is not a valid RFC No.';
        Text10001: Label '%1 is not a valid CURP No.';
        Text10002: Label 'The RFC No. %1 is used by another company.';
        SelectVendorErr: Label 'You must select an existing vendor.';
        CreateNewVendTxt: Label 'Create a new vendor card for %1.', Comment = '%1 is the name to be used to create the customer. ';
        VendNotRegisteredTxt: Label 'This vendor is not registered. To continue, choose one of the following options:';
        SelectVendTxt: Label 'Select an existing vendor.';
        InsertFromTemplate: Boolean;
        PrivacyBlockedActionErr: Label 'You cannot %1 this type of document when Vendor %2 is blocked for privacy.', Comment = '%1 = action (create or post), %2 = vendor code.';
        PrivacyBlockedGenericTxt: Label 'Privacy Blocked must not be true for vendor %1.', Comment = '%1 = vendor code';
        ConfirmBlockedPrivacyBlockedQst: Label 'If you change the Blocked field, the Privacy Blocked field is changed to No. Do you want to continue?';
        CanNotChangeBlockedDueToPrivacyBlockedErr: Label 'The Blocked field cannot be changed because the user is blocked for privacy reasons.';
        PhoneNoCannotContainLettersErr: Label 'must not contain letters';


}


