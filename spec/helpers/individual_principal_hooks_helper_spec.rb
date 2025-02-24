#-- encoding: UTF-8

#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2021 the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See COPYRIGHT and LICENSE files for more details.
#++

require 'spec_helper'

describe IndividualPrincipalHooksHelper, type: :helper do
  let(:user) { FactoryBot.build(:user) }
  let(:placeholder_user) { FactoryBot.build(:placeholder_user) }

  describe '#individual_principal_key' do
    it 'returns the class name in underscore format' do
      expect(helper.individual_principal_key(user)).to eql(:user)
      expect(helper.individual_principal_key(placeholder_user)).to eql(:placeholder_user)
    end
  end

  describe '#call_individual_principals_memberships_hook' do
    context 'with user and without context' do
      before do
        expect(helper).to receive(:call_hook).with(:view_users_memberships_table_foo,
                                                   user: user)
      end

      it 'call call_hook with the correct arguments' do
        helper.call_individual_principals_memberships_hook(user, 'foo')
      end
    end

    context 'with placeholder user and without context' do
      before do
        expect(helper).to receive(:call_hook).with(:view_placeholder_users_memberships_table_foo,
                                                   placeholder_user: placeholder_user)
      end

      it 'call call_hook with the correct arguments' do
        helper.call_individual_principals_memberships_hook(placeholder_user, 'foo')
      end
    end

    context 'with user and with context' do
      before do
        expect(helper).to receive(:call_hook).with(:view_users_memberships_table_foo,
                                                   user: user,
                                                   yay: 'yo')
      end

      it 'call call_hook with the correct arguments' do
        helper.call_individual_principals_memberships_hook(user, 'foo', yay: 'yo')
      end
    end
  end
end
