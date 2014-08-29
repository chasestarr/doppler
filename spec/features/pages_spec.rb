require 'spec_helper'

describe 'Authentication' do
  context 'authentication' do
    before do
      visit '/docs/authentication'
    end
    it 'displays authentication' do
      expect(page.body).to include 'Authenticate with an XAPP Token'
    end
    it 'syntax highlights code' do
      expect(page.all('.CodeRay .code pre').count).to be > 0
    end
    it 'adds style to tables' do
      expect(page.all('table.table-bordered.table-striped').count).to be > 0
    end
  end
  context 'docs' do
    before do
      visit '/docs'
    end
    it 'displays docs' do
      expect(page.body).to include 'Documentation'
    end
  end
  Rails.application.routes.routes
    .map { |r| r.path.source.match(/\/([\/\w]*)/)[0] }
    .select { |path| path.starts_with?("/docs/") }.each do |path|
    context path do
      before do
        visit path
      end
      it 'displays a breadcrumb back to docs' do
        expect(page).to have_css "a[href='/docs']"
      end
    end
  end
end
