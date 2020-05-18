# frozen_string_literal: true

module LighthouseBGS
  class BenefitClaimWebService < LighthouseBGS::Base
    def bean_name
      'BenefitClaimServiceBean'
    end

    def self.service_name
      'claims'
    end

    def find_by_vbms_file_number(file_number)
      response = request(:find_benefit_claim, 'fileNumber': file_number)

      response.body[:find_benefit_claim_response][:return][:participant_record][:selection] ||
        Array.wrap(response.body[:find_benefit_claim_response][:return][:participant_record]) || []
    end

    def find_claim_detail_by_id(id)
      response = request(:find_benefit_claim_detail, 'benefitClaimId': id)

      response.body[:find_benefit_claim_detail_response][:return] || []
    end

    # We have no idea what reason 1 is, these are only being used in UAT for testing purposes
    def clear_end_product(file_number:, end_product_code:, modifier:, reason: '1')
      response = request(:clear_benefit_claim, 'clearBenefitClaimInput': {
                           'fileNumber': file_number,
                           'payeeCode': '00',
                           'benefitClaimType': '1',
                           'endProductCode': end_product_code,
                           'incremental': modifier,
                           'pclrReasonCode': reason
                         })

      response.body || []
    end

    def cancel_end_product(file_number:, end_product_code:, modifier:, reason: '1')
      response = request(:cancel_benefit_claim, 'cancelBenefitClaimInput': {
                           'fileNumber': file_number,
                           'payeeCode': '00',
                           'benefitClaimType': '1',
                           'endProductCode': end_product_code,
                           'incremental': modifier,
                           'pcanReasonCode': reason
                         })

      response.body || []
    end

    # either date_of_claim OR suspense_date must be populated mm/dd/yyyy
    def insert_benefit_claim(
      file_number:,
      ssn:,
      benefit_claim_type:,
      payee:,
      end_product:,
      end_product_code:,
      first_name:,
      last_name:,
      city:,
      state:,
      postal_code:,
      country:,
      disposition:,
      section_unit_no:,
      folder_with_claim:,
      end_product_name:,
      pre_discharge_indicator:,
      date_of_claim: nil,
      title_name: nil,
      middle_name: nil,
      suffix_name: nil,
      address_line1: nil,
      address_line2: nil,
      address_line3: nil,
      postal_code_plus4: nil,
      day_time_area_code: nil,
      day_time_phone_number: nil,
      night_time_area_code: nil,
      night_time_phone_number: nil,
      email_address: nil,
      suspense_date: nil,
      future_reason: nil,
      claimant_ssn: nil,
      beneficiary_date_of_birth: nil,
      power_of_attorney: nil,
      guf_war_registry_permit: nil,
      suppress_acknowledgement_letter: nil,
      special_issue_case: nil,
      in_take_site: nil,
      soj: nil,
      mlty_postal_type_cd: nil,
      mlty_post_office_type_cd: nil,
      foreign_mail_code: nil,
      address_type: nil,
      bypass_indicator: nil,
      bnft_claim_id: nil,
      allow_poa_access: nil,
      allow_poa_cadd: nil,
      submtr_role_type_cd: nil,
      submtr_applcn_type_cd: nil,
      award_soj: nil,
      pow_number_of_days: nil,
      homeless_indicator: nil,
      ptcpnt_id_claimant: nil,
      pre_dschrg_type_cd: nil,
      person_org_ind: nil,
      payee_org_name: nil,
      payee_org_type: nil,
      payee_org_title: nil,
      group_one_validated_ind: nil,
      prvnc_nm: nil,
      trtry_nm: nil,
      treasury_mailing_address1: nil,
      treasury_mailing_address2: nil,
      treasury_mailing_address3: nil,
      treasury_mailing_address4: nil,
      treasury_mailing_address5: nil,
      treasury_mailing_address6: nil,
      fiduciary_one_last_name: nil,
      fiduciary_one_first_name: nil,
      fiduciary_one_middle_name: nil,
      fiduciary_one_suffix_name: nil,
      fiduciary_org_name: nil,
      ptcpnt_id_fiduciary_one: nil,
      fiduciary_org_title: nil,
      fiduciary_org_type: nil,
      fiduciary_prep_phrase_type: nil
    )

      response = request(
        :insert_benefit_claim,
        {
          "benefitClaimInput": {
            "fileNumber": file_number,
            "ssn": ssn,
            "benefitClaimType": benefit_claim_type,
            "payee": payee,
            "endProduct": end_product,
            "endProductCode": end_product_code,
            "firstName": first_name,
            "lastName": last_name,
            "city": city,
            "state": state,
            "postalCode": postal_code,
            "country": country,
            "disposition": disposition,
            "sectionUnitNo": section_unit_no,
            "folderWithClaim": folder_with_claim,
            "endProductName": end_product_name,
            "preDischargeIndicator": pre_discharge_indicator,
            "dateOfClaim": date_of_claim,
            "titleName": title_name,
            "middleName": middle_name,
            "suffixName": suffix_name,
            "addressLine1": address_line1,
            "addressLine2": address_line2,
            "addressLine3": address_line3,
            "postalCodePlus4": postal_code_plus4,
            "dayTimeAreaCode": day_time_area_code,
            "dayTimePhoneNumber": day_time_phone_number,
            "nightTimeAreaCode": night_time_area_code,
            "nightTimePhoneNumber": night_time_phone_number,
            "emailAddress": email_address,
            "suspenseDate": suspense_date,
            "futureReason": future_reason,
            "claimantSsn": claimant_ssn,
            "beneficiaryDateOfBirth": beneficiary_date_of_birth,
            "powerOfAttorney": power_of_attorney,
            "gulfWarRegistryPermit": guf_war_registry_permit,
            "suppressAcknowledgementLetter": suppress_acknowledgement_letter,
            "specialIssueCase": special_issue_case,
            "inTakeSite": in_take_site,
            "soj": soj,
            "mltyPostalTypeCd": mlty_postal_type_cd,
            "mltyPostOfficeTypeCd": mlty_post_office_type_cd,
            "foreignMailCode": foreign_mail_code,
            "addressType": address_type,
            "bypassIndicator": bypass_indicator,
            "bnftClaimId": bnft_claim_id,
            "allowPoaAccess": allow_poa_access,
            "allowPoaCadd": allow_poa_cadd,
            "submtrRoleTypeCd": submtr_role_type_cd,
            "submtrApplcnTypeCd": submtr_applcn_type_cd,
            "awardSoj": award_soj,
            "powNumberOfDays": pow_number_of_days,
            "homelessIndicator": homeless_indicator,
            "ptcpntIdClaimant": ptcpnt_id_claimant,
            "preDschrgTypeCd": pre_dschrg_type_cd,
            "personOrgInd": person_org_ind,
            "payeeOrgName": payee_org_name,
            "payeeOrgType": payee_org_type,
            "payeeOrgTitle": payee_org_title,
            "groupOneValidatedInd": group_one_validated_ind,
            "prvncNm": prvnc_nm,
            "trtryNm": trtry_nm,
            "treasuryMailingAddress1": treasury_mailing_address1,
            "treasuryMailingAddress2": treasury_mailing_address2,
            "treasuryMailingAddress3": treasury_mailing_address3,
            "treasuryMailingAddress4": treasury_mailing_address4,
            "treasuryMailingAddress5": treasury_mailing_address5,
            "treasuryMailingAddress6": treasury_mailing_address6,
            "fiduciaryOneLastName": fiduciary_one_last_name,
            "fiduciaryOneFirstName": fiduciary_one_first_name,
            "fiduciaryOneMiddleName": fiduciary_one_middle_name,
            "fiduciaryOneSuffixName": fiduciary_one_suffix_name,
            "fiduciaryOrgName": fiduciary_org_name,
            "ptcpntIdFiduciaryOne": ptcpnt_id_fiduciary_one,
            "fiduciaryOrgTitle": fiduciary_org_title,
            "fiduciaryOrgType": fiduciary_org_type,
            "fiduciaryPrepPhraseType": fiduciary_prep_phrase_type
          }
        },
        ssn
      )

      response.body[:insert_benefit_claim_response][:return]
    end
  end
end
