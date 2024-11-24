table 52178555 "RFQ Suppliers Category"
{
    LookupPageId = "RFQ Category Suppliers";
    DrillDownPageId = "RFQ Category Suppliers";
    fields
    {
        field(1; "Document No."; Code[30])
        {

        }
        field(2; "Supplier No"; code[20])
        {

        }
        field(3; "Supplier Name"; Text[100])
        {

        }
        field(4; "Email"; Text[80])
        {

        }
        field(5; "Telephone No."; Text[100])
        {

        }
        field(6; "Prequalification Period"; code[100])
        {

        }
        field(7; "Select"; Boolean)
        {

        }


    }

    keys
    {
        key(key1; "Document No.", "Supplier No")
        {
        }
    }
    procedure SubmitSelected()
    var
        ReqVendor: Record "PROC-Quotation Request Vendors";
        selectedVend: Record "RFQ Suppliers Category";
    begin
        ReqVendor.Reset();
        ReqVendor.SetRange("Document Type", ReqVendor."Document Type"::"Request for Quotation");
        ReqVendor.SetRange("Document No.", Rec."Document No.");
        ReqVendor.DeleteAll();

        selectedVend.Reset();
        selectedVend.SetRange("Document No.", Rec."Document No.");
        selectedVend.SetRange(Select, true);
        if selectedVend.Find('-') then begin
            repeat
                ReqVendor.Init();
                ReqVendor."Document Type" := ReqVendor."Document Type"::"Request for Quotation";
                ReqVendor."Document No." := selectedVend."Document No.";
                ReqVendor."Vendor No." := selectedVend."Supplier No";
                ReqVendor.Validate("Vendor No.");
                ReqVendor.Email := selectedVend.Email;
                ReqVendor."Prequalification Period" := selectedVend."Prequalification Period";
                ReqVendor."Telephone No." := selectedVend."Telephone No.";
                ReqVendor.Insert();
            until selectedVend.NEXT = 0;
            ReqVendor.Reset();
            ReqVendor.SetRange("Document Type", ReqVendor."Document Type"::"Request for Quotation");
            ReqVendor.SetRange("Document No.", selectedVend."Document No.");
            if ReqVendor.Find('-') then
                page.Run(page::"Quotation Request Vendors", ReqVendor);
        end;

    end;
}