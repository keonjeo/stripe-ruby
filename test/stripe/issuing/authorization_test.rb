# frozen_string_literal: true

require ::File.expand_path("../../../test_helper", __FILE__)

module Stripe
  module Issuing
    class AuthorizationTest < Test::Unit::TestCase
      should "be listable" do
        authorizations = Stripe::Issuing::Authorization.list
        assert_requested :get, "#{Stripe.api_base}/v1/issuing/authorizations"
        assert authorizations.data.is_a?(Array)
        assert authorizations.data[0].is_a?(Stripe::Issuing::Authorization)
      end

      should "be retrievable" do
        authorization = Stripe::Issuing::Authorization.retrieve("iauth_123")
        assert_requested :get, "#{Stripe.api_base}/v1/issuing/authorizations/iauth_123"
        assert authorization.is_a?(Stripe::Issuing::Authorization)
      end

      should "be saveable" do
        authorization = Stripe::Issuing::Authorization.retrieve("iauth_123")
        authorization.metadata["key"] = "value"
        authorization.save
        assert_requested :post, "#{Stripe.api_base}/v1/issuing/authorizations/#{authorization.id}"
        assert authorization.is_a?(Stripe::Issuing::Authorization)
      end

      should "be updateable" do
        authorization = Stripe::Issuing::Authorization.update("iauth_123", metadata: { foo: "bar" })
        assert_requested :post, "#{Stripe.api_base}/v1/issuing/authorizations/iauth_123"
        assert authorization.is_a?(Stripe::Issuing::Authorization)
      end

      should "be approveable" do
        authorization = Stripe::Issuing::Authorization.retrieve("iauth_123")
        authorization.approve
        assert_requested :post, "#{Stripe.api_base}/v1/issuing/authorizations/iauth_123/approve"
        assert authorization.is_a?(Stripe::Issuing::Authorization)
      end

      should "be declineable" do
        authorization = Stripe::Issuing::Authorization.retrieve("iauth_123")
        authorization.decline
        assert_requested :post, "#{Stripe.api_base}/v1/issuing/authorizations/iauth_123/decline"
        assert authorization.is_a?(Stripe::Issuing::Authorization)
      end
    end
  end
end
