class StaticPagesController < ApplicationController
  def about
      def hello
          render html: "About Page"
      end
  end

  def contact
      def hello
          render html: "Contact Page"
      end
  end

  def login
      def hello
          render html: "LogIn Page"
      end
  end

  def register
      def hello
          render html: "Register Page"
      end
  end
end
