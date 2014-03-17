require 'spec_helper'

describe 'broker/allocations/edit.html.haml' do

  let(:region) { Fabricate(:region) }
  let(:job) { Fabricate(:job) }
  let(:allocation) { Fabricate(:allocation) }

  before do
    assign(:job, job)
    assign(:allocation, allocation)
    view.stub(current_region: region)
    render
  end

  context 'form elements' do
    it 'renders the allocation input' do
      expect(rendered).to have_field('Jugendlicher')
      expect(rendered).to have_field('Nachricht')
    end

    context 'form actions' do
      it 'renders the edit button' do
        expect(rendered).to have_button('Bearbeiten')
      end
    end
  end

  context 'global actions' do
    it 'contains the link to the job' do
      expect(rendered).to have_link('Zurück', broker_job_path(job))
    end
  end
end
