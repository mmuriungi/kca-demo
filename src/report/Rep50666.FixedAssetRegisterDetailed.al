report 50666 "Fixed Asset Register Detailed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Fixed Asset Register Detailed.rdl';

    dataset
    {
        dataitem(FA; "Fixed Asset")
        {
            // PrintOnlyIfDetail = false;
            // column(seq;seq)
            // {
            // }
            // column(StartDate;StartDate)
            // {
            // }
            // column(EndDate;EndDate)
            // {
            // }
            // column(MonthName;MonthName)
            // {
            // }
            // column(FANo;FA."No.")
            // {
            // }
            // column(Description;FA.Description)
            // {
            // }
            // column(SourceOfFunds;FA."Source of funds")
            // {
            // }
            // column(SerialNo;FA."Serial No.")
            // {
            // }
            // column(TagNo;FA."Tag No")
            // {
            // }
            // column(Model;FA."Make or Model")
            // {
            // }
            // column(CompAddress;info.Address)
            // {
            // }
            // column(CompAddress1;info."Address 2")
            // {
            // }
            // column(CompPhonenO;info."Phone No.")
            // {
            // }
            // column(CompPhoneNo2;info."Phone No. 2")
            // {
            // }
            // column(CompPic;info.Picture)
            // {
            // }
            // column(CompEmail1;info."E-Mail")
            // {
            // }
            // column(CompHome;info."Home Page")
            // {
            // }
            // column(DeliveryDate;FA."Date of Delivery")
            // {
            // }
            // column(CurrentLocation;FA."Location Code")
            // {
            // }
            // column(OrginalLocation;FA."FA Location Code")
            // {
            // }
            // column(ReplacementDate;FA."Replacement Date")
            // {
            // }
            // column(PurchaseAmount;FA."Purchase Amount")
            // {
            // }
            // column(DepeciationRate;FA."Depreciation Rate")
            // {
            // }
            // column(AnnualDepreciation;FA."Annual Depreciation")
            // {
            // }
            // column(AccumulatedDepreciation;FA."Accumulated Depreciation")
            // {
            // }
            // column(NBV;FA."Book Value")
            // {
            // }
            // column(DisposalDate;FA."Disposal Date")
            // {
            // }
            // column(DisposalAmount;FA."Disposal Amount")
            // {
            // }
            // column(Responsible;FA."Responsible Employee")
            // {
            // }
            // column(Condition;FA.Condition)
            // {
            // }
            // column(Notes;FA.Notes)
            // {
            // }
            // column(PVNo;FA."Payment Voucher No.")
            // {
            // }

            // trigger OnAfterGetRecord()
            // begin
            //     seq:=seq+1;
            //     /*IntMonth:=DATE2DMY(SalesHeader."Posting Date",2);
            //     IF IntMonth<>0 THEN BEGIN
            //       IF IntMonth=1 THEN BEGIN
            //         MonthName:='JAN';
            //         END ELSE IF IntMonth=2 THEN BEGIN
            //           MonthName:='FEB';
            //           END  ELSE IF IntMonth=3 THEN BEGIN
            //             MonthName:='MAR';
            //           END  ELSE IF IntMonth=4 THEN BEGIN
            //             MonthName:='APRIL';
            //           END  ELSE IF IntMonth=5 THEN BEGIN
            //             MonthName:='MAY';
            //           END  ELSE IF IntMonth=6 THEN BEGIN
            //             MonthName:='JUNE';
            //           END  ELSE IF IntMonth=7 THEN BEGIN
            //             MonthName:='JULY';
            //           END  ELSE IF IntMonth=8 THEN BEGIN
            //             MonthName:='AUG';
            //           END  ELSE IF IntMonth=9 THEN BEGIN
            //             MonthName:='SEPT';
            //           END  ELSE IF IntMonth=10 THEN BEGIN
            //             MonthName:='OCT';
            //           END  ELSE IF IntMonth=11 THEN BEGIN
            //             MonthName:='NOV';
            //           END  ELSE IF IntMonth=12 THEN BEGIN
            //             MonthName:='DEC';
            //           END
            //       END;*/

            // end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        if info.Get() then begin
            info.CalcFields(Picture);
        end;

        Clear(seq);
    end;

    var
        info: Record "Company Information";
        route: Code[20];
        MonthName: Code[20];
        IntMonth: Integer;
        StartDate: Date;
        EndDate: Date;
        seq: Integer;
}

